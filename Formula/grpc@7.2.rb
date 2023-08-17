# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "13162e9940b86ff6b75ae1b281cdc311a69d89d24bd4fb60e3723105206d9eb9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "57806f9d89cf9a2026e3e29c1d9fe11ebdb8d1f5092025e0031194d2e81b8343"
    sha256 cellar: :any_skip_relocation, ventura:        "32eb97b2aa3c59d5525529b6e501575efb551f76bf5e6eed9070341ee1d20252"
    sha256 cellar: :any_skip_relocation, monterey:       "beeca2ec2889e2fdc30da0921e31d60d1d2d2bddfa44c8d28285f6bd12fe2673"
    sha256 cellar: :any_skip_relocation, big_sur:        "efdd54fd53adebf7ea391a8ad5f4acb163906194818e578dc38102c833e57e08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a675a7e5488fb96fe543d8aebeffef9a0eac5de63cdd8b7ba34b00527c620ee"
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
