# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c9cb928c0f2a072877e46ec6c4b7086ae3ef6f076aa781a24c57ac564551c103"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0d0be5e86e435b7983c8c2c2acf8c7b78e3ee1f03f11cccde9dfebc5661b2745"
    sha256 cellar: :any_skip_relocation, ventura:        "5b0b895f9041a3dc6393eabcfa9350e234f283a45ae8db4c07ab8d95e1fa0255"
    sha256 cellar: :any_skip_relocation, monterey:       "a202feaf0751fe3b30152294ab4882b74168c578a5872876a2db69311e89490e"
    sha256 cellar: :any_skip_relocation, big_sur:        "1d3196df9407b72298b9982307dcfa63b028310f0916f7cf4ccd36f984ab8b89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "64848e8e12536b4b83717f97c54cacabf9f305807a40a35e865110c0fdb74b74"
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
