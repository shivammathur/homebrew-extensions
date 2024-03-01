# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.62.0.tgz"
  sha256 "ceabf3c564cd3d61ca7a9a06ebdde777322e50701a454f1c5d8a5291afe59302"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7b7f2f72f6383c8899b6c8d03a3310df91ccac827d48d73225be6b4465a0a43e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "74cd20edccb86899cfc8ae0043c592cff9040d1c5f5df065220da0a9f3c989f7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "070b836425aa6856e831f2af33bf099b6a08b6a0194a9e967eedfe9c19e0feda"
    sha256 cellar: :any_skip_relocation, ventura:        "7946350c43f32680fb13b2a65fd21a5370aaea0f6f323f3a6236d4c410709ab4"
    sha256 cellar: :any_skip_relocation, monterey:       "fd773e073513672826aeb7eac002aea5ebb917f2c7ddf26414ed665a59de369c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "255596b39f6286f4c417fa3dbba5f3beea03d761c523f1b7924c83910bacd2e3"
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
