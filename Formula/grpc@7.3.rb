# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.38.0.tgz"
  sha256 "4bec8f981b7b074ed78bc42ef229dcfb6c5fe3782f29bc4980b4da00866d47f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7a4cf7c3cd0a7efc8bef485a7c03c7befe73874eee910a1a222b97581bdd74fc"
    sha256 cellar: :any_skip_relocation, big_sur:       "feda976d15afadcdca705b8eb7f1db8530f276ef49804430fea738c78d3025fc"
    sha256 cellar: :any_skip_relocation, catalina:      "e05ac1c11e17f172807e5285d6b382906477b340d4d54a4747bd88271c6b5a9e"
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
