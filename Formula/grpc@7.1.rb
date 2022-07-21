# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "98140facfb31c02fade5fb1de82113b3cb5bfebf46d2d6e1d19e2c0fa983af91"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b818fc11c3abdbfbe704a0310e0a2871a8c3081e3e17672798922274a39be2b0"
    sha256 cellar: :any_skip_relocation, monterey:       "774d600a3a20da9867176e986d7350d274f9ef488f40c325c1b1214c85680bdc"
    sha256 cellar: :any_skip_relocation, big_sur:        "ff7f3fe6cb672050ce372675db1c4fa2ec15363d3e65e3ebc17f0e13404336cc"
    sha256 cellar: :any_skip_relocation, catalina:       "55781b0c7ba1e35b57abb8e4cdf267e3811438259b3305238dd5f10c5ed66a7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8e7d3989e94b649e7acdb18666108453c6d251e738ece4ec2c3f176a0fbe064d"
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
