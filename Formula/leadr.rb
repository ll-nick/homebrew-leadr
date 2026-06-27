class Leadr < Formula
  desc "Shell aliases on steroids"
  homepage "https://github.com/ll-nick/leadr"
  version "2.8.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.6/leadr-v2.8.6-aarch64-apple-darwin"
      sha256 "ffaabdc05ecfdb823d1da0f027c6f39553822a501f3c47aa4202b9846c73e7cc"
    else
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.6/leadr-v2.8.6-x86_64-apple-darwin"
      sha256 "7dea3bea7fee8864af98dcd8d5e771dafb2719164bff820fde824e8d4df2da6f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.6/leadr-v2.8.6-aarch64-unknown-linux-musl"
      sha256 "dc90bccec9ea8d675a020c35dbd7a3e8d514828537fc545e9db0309ca1468ac5"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_32_bit?
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.6/leadr-v2.8.6-armv7-unknown-linux-musleabihf"
      sha256 "f41ab961394747cbaff1d2a5a8445b1a3628931a29b40119bcf821ab6cb4ac77"
    elsif Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.6/leadr-v2.8.6-x86_64-unknown-linux-musl"
      sha256 "77b6f729324266117f035c8baea27976a50b39c8eb4a76e16ee23bdafc0506ba"
    else
      odie "leadr: no prebuilt binary available for this CPU on Linux"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        binary_name = "leadr-v#{version}-aarch64-apple-darwin"
      else
        binary_name = "leadr-v#{version}-x86_64-apple-darwin"
      end
    else
      if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
        binary_name = "leadr-v#{version}-x86_64-unknown-linux-musl"
      elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
        binary_name = "leadr-v#{version}-aarch64-unknown-linux-musl"
      else
        binary_name = "leadr-v#{version}-armv7-unknown-linux-musleabihf"
      end
    end

    bin.install binary_name => "leadr"
  end

  test do
    system "#{bin}/leadr", "--version"
  end
end
