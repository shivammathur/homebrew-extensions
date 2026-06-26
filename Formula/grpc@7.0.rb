# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "098584bf44906233caa647c5f72230be4e2fa37cf1b8f5e6e26f3cf0cdc7f4c2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6c055fecb394bc98d0a191abcccf2675d0e53cce112348d9583f13cfe967ce5d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "32024e840263931a969f6a4500384db8a5094040dfc8aefe3df84bd744bac2fb"
    sha256 cellar: :any_skip_relocation, sonoma:        "3adb207149f78e27f9e033068aab88d4cd2b487a5b6baa321b24a2fa87f8ec2a"
    sha256 cellar: :any,                 arm64_linux:   "faf134bdf6b92bfc5ea29051b696c91ae91786fd2603a7e3374a74c014e3c0bb"
    sha256 cellar: :any,                 x86_64_linux:  "698a7c586d905f267ac6240ffffb8b1c01d3de7dc406afcf1155c0e3ac0033f6"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
