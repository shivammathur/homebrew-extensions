# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b2895758eb26fb27dce83656be6e6ead1ed0222247695159b1a2ad2e012db5f9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c84f51adba31ba0cf9b05010a31c85eae37ee94ec3765fbac9f54c11fd22729c"
    sha256 cellar: :any_skip_relocation, ventura:        "1a3673f61ef254c45ed2ec5999ce935c3aaf76f329a31afafd8937068fb904fd"
    sha256 cellar: :any_skip_relocation, monterey:       "12897a8b34faad396eb873b78c3128654f83644b996e5f4b22b93a10cf90d192"
    sha256 cellar: :any_skip_relocation, big_sur:        "c6a5831cba20c8307b4f2daa77c5937b4f7328d9e3348c7ef4ae392dfc67a7b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4d6a6fa2e284d46d684667e9707caaa07547520c1dac7d4688dc5332d038329d"
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
