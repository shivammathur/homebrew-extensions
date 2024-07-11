# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c5aba4e025654ce16908c5065b8c175ce9ee16bbac31157d1ab96c8afefb7e7a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "39cccc55ed3435d8bd288338e77fd2ca9359ff21acb60d3472146f4f92694df6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "69533e068ce1c2ef88dee57375a21beba8dc33f7fdbca30ad65d615e7dc83e81"
    sha256 cellar: :any_skip_relocation, ventura:        "97e96e6fa6f9e1f0f5eee4f8ec7ae44c1a5163880e6f7d94aef158f62a3b324e"
    sha256 cellar: :any_skip_relocation, monterey:       "f1f9d4e0ab57d36402781a52322ee98564b4be5318dd24a4c8212f0c0755bf5c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3228bc4c13b73af1ef6e6868c80f232629c96278053541bf7b4bf50e3ab2210e"
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
