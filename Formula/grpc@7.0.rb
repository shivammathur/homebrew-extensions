# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "03e622476716e28b778abb01e1049a364507a99c5623010445000a1060ce5308"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "44c61d69eb763dd0783f9fc42eb3a9444ba8ebe8ab9d7f37e16b76a47254ac7f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "50637098079906c81bd4fdd54994c86f7b22a14e6be722e33889bd7084f749a6"
    sha256 cellar: :any_skip_relocation, ventura:        "d7b8cfd762cf6c982e1495746ebbee405f35b5a55de309b48b6346d750999681"
    sha256 cellar: :any_skip_relocation, monterey:       "08f473032b0a17c86b9b6cc7ef6cb1a9d5709fb2abb1c2518c69671edaf3cb7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "72b9ad876c74cd704c6503c5f5fb0184f6513e5b1530536a1a7f8cdd19a3def6"
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
