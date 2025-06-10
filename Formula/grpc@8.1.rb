# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.73.0.tgz"
  sha256 "63959dc527c60cdb056842c5e5ebb45b507452bb121653604ed94c1c23972c7d"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f2b01a52daf8e5654b9a075bda46a8b6958a98d3dac21d94d28232d0ed63ef65"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d23fc895dda9d2c8e2e03e58d73f356dea1bf3d59db6a4b6252730f1fabe7b16"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4dbecd90df0975bf03d1811fd2ff6864dcb3dc9f365e2b236b45a054cfac8e48"
    sha256 cellar: :any_skip_relocation, ventura:       "b83a6b429a21899313dfe5649f79958ecc3b05a3120bfd34ca77cfa93aeb39e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5c4ce728071b464464f2eb5aa70a9e49e6c459c911107e281bd49f428bdec2d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a72f7009599926e5b25a65f07deb789afd497a8d6ad5e2c636be198c118b3c2b"
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
