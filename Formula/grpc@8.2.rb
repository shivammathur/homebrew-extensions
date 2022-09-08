# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.1.tgz"
  sha256 "74e22f8eaf833e605e72ef77df3d432bc6d99647df532d972f161874053859e0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "439887c9fa6cd9f7449d36d03d215c527e8478d9026e2fcad6577a2dfe7ec62b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "12b7716d068346036a7b39861af30b17d83fb49c26a60eaf535f5127347aec69"
    sha256 cellar: :any_skip_relocation, monterey:       "4ef3f8d7fe0f2272dd757035340d9509ba9ae2beaf442836b94d834cd538b18c"
    sha256 cellar: :any_skip_relocation, big_sur:        "66667fcada3f1ee574fd984017173fedd92721f84f8668067f24f067efae6244"
    sha256 cellar: :any_skip_relocation, catalina:       "fb020aa0b2f639d73cd4b358b466fda6e4567c4a32dafd68e3ca81c6ffefb6fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d15a71982f82a014603c5a18d6eef433fda838145bd3865519a347fa99c204ad"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
