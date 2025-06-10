# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d678a00929e33ca51bf7c481e9bbe52ac07a119f80ca0b24f0f52931402d659b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c1d873f3d9a870d660f487b4cda750c2576cc30b199dd8bf1ca89647e332cb39"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9bf6dda44d771d5a2eacb8aa4cd83e18ab3f2e3792ed7a82bb7f6f2fa0d0e08a"
    sha256 cellar: :any_skip_relocation, ventura:       "14da7ad406db93ced6fea4921a1c64c071934feb97b1123930b7ce2791939ad8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "91f805d8ce2884b5a20ca3a92fd9d564afeebeb0786b090a81a414bc435d70ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "050b6cbd2d321f2489f6d57b0cca4ac8be97e25aa20a94a9a1eb969dac836872"
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
