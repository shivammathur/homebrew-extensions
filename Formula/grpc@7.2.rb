# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhp72Extension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.0.tgz"
  sha256 "591317e428276a05ca578dce778d4ade47d777a1efa9509db4dd480f82a5e822"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6e8a39cd0a8c967dd2015dbfda088203431883f53fee4d38bf0cd0579e053244"
    sha256 cellar: :any_skip_relocation, big_sur:       "0ef05ecbbe100f98733f81a0f922b751024ba3a0501061d1236274d3016c842d"
    sha256 cellar: :any_skip_relocation, catalina:      "ec5759b628ce67b0c01941b81b657f816bb16e38c3002aa953682c9d1a09b23e"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
