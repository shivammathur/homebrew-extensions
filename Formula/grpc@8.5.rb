# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.0.tgz"
  sha256 "b12c7e0e048df728a4f2c513aeaa78ae18ad5c3ab3b607eeae398e0e1bab12ea"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cde0631308a3be699f02a3ebeb210d85aaeb97a3761468d7a88805f80ec87221"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "17ccacbadbc06659bd9c60dd1eb29ece054f70d1724ef9e80340150af6997837"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "08cac24f5aa3c9f73141280286a317d03f22cdbb0e6defff0566be8564c37835"
    sha256 cellar: :any_skip_relocation, sonoma:        "bc1d305fbd1a19b16ac4360620400bdd51bd538056d6d1c2a7a662c4a6d4a619"
    sha256 cellar: :any,                 arm64_linux:   "6806f97104ead245fdb576ae3adfa598654a8b922f448acd8ee000c8b1c19e41"
    sha256 cellar: :any,                 x86_64_linux:  "697f4ee526352d12c59f5d6be850042f735232ce4c36a2683140b991b5f5d1e0"
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
