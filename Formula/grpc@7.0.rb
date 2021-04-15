# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.37.0.tgz"
  sha256 "591317e428276a05ca578dce778d4ade47d777a1efa9509db4dd480f82a5e822"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cb1aaea15f0ed4cac98e85928c2da1459d9c54a199247319164c92df40b42a41"
    sha256 cellar: :any_skip_relocation, big_sur:       "c24734dcfaf1d2db475012142e2bf6b725cf9afc3036003f70db2952732f6ea8"
    sha256 cellar: :any_skip_relocation, catalina:      "ace55094050db5cef33188dd356e82cd5a97b97552cbb7200b8b0a466fe5650f"
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
