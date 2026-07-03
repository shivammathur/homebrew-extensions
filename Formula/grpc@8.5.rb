# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.82.0.tgz"
  sha256 "bbcb83e229b565feac351bd88bd80091c4ef613357122fccf8a9930cd988d6ca"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "769247d62aa114d48d6eb1b6c2e33b5530aa090f482e37e4ea1cc7b24526a526"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7c38239e6517f36c24402845bdb1358d38893e9d01691d13c40fa9b20914d7c3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6567f0a89eb93b4ce83a90a44606363acfb94b60e9ba29f843dba221f32e0bb5"
    sha256 cellar: :any_skip_relocation, sonoma:        "cfaf2bb7fe62fe838dea1943e31851986da1154c030898b5aed9fc276e04798c"
    sha256 cellar: :any,                 arm64_linux:   "3a604e5ff645b125d9a57e05eef894f53f7e03f0894503c963fc150c452fcde9"
    sha256 cellar: :any,                 x86_64_linux:  "4b3c40efe8332104e4c8b3d226713fa878e342a9449fb205ad2a693d96e00461"
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
