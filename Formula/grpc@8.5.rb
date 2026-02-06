# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5ae65a4c03403851b4084afe793e8eb840b9c59348a3d2380824ae3f35bd9c70"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3d1b61a1c313d7308db545d308bf872a7a49d57acb88e4c6315ef5fa6aa5655c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e690c242ea4a997e2d2a1ed773b24153178e31bbceef1b3888434faab85f34f5"
    sha256 cellar: :any_skip_relocation, sonoma:        "e05cb75c3d5dcd88a6ad1e655eb39455cdb82ed58069897b9d467c2f4ba5c027"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bcd9ff70fd088af327be46d3ecd15bfbee315bd84fa5ca1dffbc4d0c26077df0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9819ce35d7f58e117715c5b5d5945a7dc8180d895959842c7df813a8cc135d0e"
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
