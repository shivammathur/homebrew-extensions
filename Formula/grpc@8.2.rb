# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.64.1.tgz"
  sha256 "7eedbce54e29281d8fb97b0924e34d6cb315c5ba12e8a55706ccdde977497d43"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "20417a44c9a1114a4c3cee08438be5ee49f879be297c4ff9ecf973d1cf243bf6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "15d0a40bc991a7bf64fc3cec3e7430714c2ca89a2ef2680e970da7b9ca60f808"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "13153af72d6974febcb5fd452fbab8f3e943e51d4721ed678afb01c21845c062"
    sha256 cellar: :any_skip_relocation, ventura:        "859212ca2c90ed7516f3fadc9160f5e4d421400a6422284312a167e84988efbc"
    sha256 cellar: :any_skip_relocation, monterey:       "134c57139be21b45d836d415c24484ed52a5e029ae5476c21a4e95bcac1f68e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "46e9da39692060162868b08dcc794b914b45e30c464ffbc70459b529812b99f4"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
