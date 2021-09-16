# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.40.0.tgz"
  sha256 "ebfb1a2e9e8378ab65efb48b2e7d8ff23f5c5514b29f63d9558556ae6436ebf1"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "55b67747f51cd4383481015e3fca5b0181eb6181a83dd600f9a05a2f53d0ade9"
    sha256 cellar: :any_skip_relocation, big_sur:       "fc7b4243fbdf39abb228ce2df5166fe3cc401e68c68c711b793a3529b5a7017d"
    sha256 cellar: :any_skip_relocation, catalina:      "66f2a299536d38302a540fcfa1330c68a965d06bb3a5575bf9b2c8ef2845094f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f10557987cec893986eaf8d96774e7ee4c51fc034162a4d2efb1f13e8665b243"
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
