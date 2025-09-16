# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9a669e92fddbe42253da8a0774f4def3d81e86dcf8d811c7e27e92110aaf4ca3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5ff7923e6b2b5de921f84c0af21c8da53511f423450159b26ffb81250d113201"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9d2f63b2a0f4b369a728a69a7997fff56c491269c5badb989a8be377eaf44a9c"
    sha256 cellar: :any_skip_relocation, ventura:       "b348ed00d8f10f5bbf80fb844d097fae47c1bf3e55fb361b6bbfbf3a61716d18"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3213944356291cebfb4eef9992174922db5dbce566b5c6b2c3f449b353732a73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "462abf834e767af964b0ed363d66b09505a409e06e7b60425c4e5a37503db00c"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    inreplace "src/php/ext/grpc/call.c", "zend_exception_get_default(TSRMLS_C)", "zend_ce_exception"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
