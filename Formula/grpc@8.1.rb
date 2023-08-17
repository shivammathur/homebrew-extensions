# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2944eb75ecebd75cef2eb71a7a9b6cb463030322427fee0d35a15e1ec87368f9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "72fe66a22cc0491b8e7ea761bb65a9b9be0cc3da2e623be0f50b135703b82424"
    sha256 cellar: :any_skip_relocation, ventura:        "ae47c7720a56b81c590f81686ebee0ed70e6dcbb320358e168e085086d0e4e43"
    sha256 cellar: :any_skip_relocation, monterey:       "19404b3dd5eae8c4dea4a4cbd0d7368183ce582c0b875ce585f0f029879807bb"
    sha256 cellar: :any_skip_relocation, big_sur:        "83545fc3b21504a1cd33ee929e5e4b3241b49ad0c1145c540f8afbb4b3da9bbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9da674a5636293434e6976193fcc983fdbefe49dc971d0399d517b3be4942ff"
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
