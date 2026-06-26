# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ae6439253690fce76d37a3067195ca882758ae52ba5aa246e41fb79247a230b4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bf58dc27cec3febdb0c1b7669ea6309e393e7cfeae3e696809a1bbc61d411191"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "628cb20a0698575b9feafec9d97735e4a8cbb7cb1d40313bbd5a366f9600c169"
    sha256 cellar: :any_skip_relocation, sonoma:        "20e64c0459f71437fb1626373da3bb5f0a3f19f9cca8775f6168b5f27f67b90c"
    sha256 cellar: :any,                 arm64_linux:   "deeeab9282160a1911be72dcf859a3d6f724d03d4b7cb28351b2d9c17ab08b42"
    sha256 cellar: :any,                 x86_64_linux:  "ddd6fc0b640fe6c1a8300a1e437f86e2150858bedf0e62e3ad352563d6dbf689"
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
