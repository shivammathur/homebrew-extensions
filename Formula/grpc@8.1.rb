# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.50.0.tgz"
  sha256 "2e0bebc351d9cb07ef1d3685f3c4f976d297bbf946479c5e4be4ecaaa3500927"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a7b4367640b7e3d984e3d59d0234d2b4b5e7393d131b3e7fb4967caf94c98c8c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4f9c2426d6b8fc9d98e5004ebc3af3375be659cc74665a9351de2fd76ff04afa"
    sha256 cellar: :any_skip_relocation, monterey:       "1895bce5b82f1a6e2eaff2f0f407c251eaf25ae06c17ae8d01885c3c198e7107"
    sha256 cellar: :any_skip_relocation, big_sur:        "5760740a3f5daacddb3283eae95fad8231a680ebae54245ed61a8219fcbc3736"
    sha256 cellar: :any_skip_relocation, catalina:       "0c98c637f3a3eb9957d6842f2e7fade061178c71eced0707434be1c3fdee972d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "549929f7485a965a45d4da95578f93be073c9c7a86f9655b9f50cb93a2f9f639"
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
