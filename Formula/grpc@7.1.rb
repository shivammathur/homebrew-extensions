# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4541da0f85c6b9a031a898bd693bfb1aa8281a8e0d5ddcb38f77d9717cf56c32"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b4e7c11804fa7289c31ffc39402fcd341c1392f7a2512a5d5d6ae5d0981e029e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "81a4c9aac6910fa3deb3ce7d724ccff3b6bfe2b3b923fffb440cdd7ac3961fc2"
    sha256 cellar: :any_skip_relocation, ventura:        "7c9c4604b3c3c50020456646a08f027b01357016f76d738a661925107a5560d8"
    sha256 cellar: :any_skip_relocation, monterey:       "0db8b80aff89635c950f43e357ca8553e4c8cbc60df90a0e651e8937d7316a27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "27ca6eb2b81d4696e3ad0e7d1690f61315cb12e7b8b9c64e4e019912b3a17206"
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
