# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.74.0.tgz"
  sha256 "972ce8a989f2c15a951444950c1febe84eb88e59aeaca29d96e005fe55df1fc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3c5fcd9a0761ddc8bd3e0aaf0b5f7c4efa40e8e2c1bd6a8330ce2ee3d0a784aa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5c4f4fb4f2164ca6d310a2bdcc076f8081321dc3707101df5f216dbb94b36bd0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ea7ce7b53b9af85861b06c9f4b22849affddd8bb07df8875e2bdf090eb1358eb"
    sha256 cellar: :any_skip_relocation, ventura:       "e0776453d6c0ee576e24243fb639eaa31e1e184f89bbb32b2b57e176d122def5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d54debcc07ad4f672438c5fcde925ab640e7922717d83e392d1b53e8f2ffe29c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aef8ab0d55bab2721128d515bca8b4b4341b26cfb269452d6d0a4e67b7a76732"
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
