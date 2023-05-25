# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.55.0.tgz"
  sha256 "75f9a465a4d1f6f337aa5dd83e5b5447064aa0a2b2776a72ec192ad7972c8295"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0541f43229ee8ee494322f6cf36e8f72425b028d6368554c99622931a8da145d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a4b1aab47019e959e299d9a62c0830b9af3bc8469200c10c717155109e512360"
    sha256 cellar: :any_skip_relocation, ventura:        "eeff96e4b13d2376128f14cd21b16a7f9bbee9e0c096daad54bbb3f029b2fb7c"
    sha256 cellar: :any_skip_relocation, monterey:       "0c680c8e3056f94f5c54f65794f2e82c41e3f79c6a107a2b749e8c2370ed3a25"
    sha256 cellar: :any_skip_relocation, big_sur:        "642ecc2af4fe215d19f5f91b8f7242b60bb6239bd1001c14208328df72167b63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ac24c1f471f512ae7623a6db42deed5b789670984818c9fe96827d30dbebc64"
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
