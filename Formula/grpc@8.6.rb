# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT86 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ce93f7c0c517c14fd5d6812aa43fa3fbb4bded2a99c7a9a74f3b6a7165a4c5ae"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "177a89e31a5d84733a9b1d589bcd3bc4359c75752eed4851cfb91aa1cd159ba8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6a2c742b1ab981b69aa026145ce1493813c972c8eeac4535b1f473c386dac181"
    sha256 cellar: :any_skip_relocation, sonoma:        "fa5e6be9c90493d06b3493cd927f83a1ce226d623b2eef71612c8dd1718a2547"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d4528977e3d6e30a904b5fd54b2c2a33f246140a076f7f841685bcd47bb7052c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11e16cffc09e784a600a0debd27fcf320f42862b83b8ef877a231e2e63942deb"
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
