# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3a86c71592ecb8e6c644f883676926c9b383ad5e754383728e083865a6504a6d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "287c544bfd7f227892a17e36c9f24682058b95d682eb28680559d63d7c9dcfc1"
    sha256 cellar: :any_skip_relocation, monterey:       "157302fe6eadca39ec422fa328f2f139e731d6cd85b111a7393226020d371e50"
    sha256 cellar: :any_skip_relocation, big_sur:        "b7552ca660e077917ce2aff0f05117b162aaf2a022f2295f53e46cbe87322c82"
    sha256 cellar: :any_skip_relocation, catalina:       "a4a49578f633c99d9128271ce9266b9c0302107d5e07cae6dc644bc65b83a9e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f182f0a8f45611704813c72b75856b0386b3538c53dba5e60bcf07ec9fe53b55"
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
