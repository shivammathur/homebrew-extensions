# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ef00a0f91aea0b019f1d264a9575ec751c9f7998d4cf36da38a2eed4a0d547df"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8c51c31602fe1ebc85e05f7c276883161a6a2366d191058e5237f7ddd9bbb815"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f3c1beb0ca5e1955451fbf9f1a0a67909679328e9a59fca577a10a1b2c2e7a1e"
    sha256 cellar: :any_skip_relocation, ventura:        "bbf2fca38bf68480deacdd95f147fa39e92aa0ad17841d7af28e14d453d645fb"
    sha256 cellar: :any_skip_relocation, monterey:       "c406658d5349b446a951451634bb0f1a98c0234338d9da67cdcf329d41383058"
    sha256 cellar: :any_skip_relocation, big_sur:        "b362e6f30261e5fed21e312746b5cbebf747091fa843a9683a0244f206cd0e1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "91bb5c780cb6152fa4f946ea3c70857c44f35c48e144c3a363b7bf9ddffad304"
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
