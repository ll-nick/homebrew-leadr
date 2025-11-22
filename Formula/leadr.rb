class Leadr < Formula
  desc "Shell aliases on steroids"
  homepage "https://github.com/ll-nick/leadr"
  version "2.8.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.5/leadr-v2.8.5-aarch64-apple-darwin"
      sha256 "a98b0786d43a563bfe33dc5666f19770e95ffd8708e5cbbccdf31f375d93fa59"
    else
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.5/leadr-v2.8.5-x86_64-apple-darwin"
      sha256 "b5c300813d45244f3f41a2b2012993e2ffbb7201051dc7779cb6fd98249bb38a"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.5/leadr-v2.8.5-aarch64-unknown-linux-musl"
      sha256 "1de282e4826c78f3ce32a4fdaf8d7e710744ba08a4481134fef71cd91553d741"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_32_bit?
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.5/leadr-v2.8.5-armv7-unknown-linux-musleabihf"
      sha256 "3660fd9c18850e5caf59a35eed36005b27dfeba4afe564d2039e67bbf189a8aa"
    elsif Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/ll-nick/leadr/releases/download/v2.8.5/leadr-v2.8.5-x86_64-unknown-linux-musl"
      sha256 "b4d04cf2462ce3b43e05dc2f00bca225205946a6fa4653c63294253e30294511"
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
