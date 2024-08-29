# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "bf12321f01f8e475d95cca1a8f10a1b5320f166bd43551e399ae2c57573e6bf0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5b9ff264f2cba1efa7c29cb460693872fa886d2da434ad87808ef2936ee3dd64"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a520f253fd6e77107264745ca764e637a9283f7a8ec22303b230a9cb2b095517"
    sha256 cellar: :any_skip_relocation, ventura:        "8ac446499d2bec6e9070546eed2bb642063b366d36f1bedcc8cbf1f202252c5e"
    sha256 cellar: :any_skip_relocation, monterey:       "d2e3ae3d140967d80d686a18477b6eb28fdb057126c47a0a7d27e067fd5e602e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ea7c7b1985bebe49d53621aa9ae138cd71e9c2557a91fcbf4b7cf0c4e195e799"
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
