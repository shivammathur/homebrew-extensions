# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.49.0.tgz"
  sha256 "dfcd402553a53aac4894b65c77e452c55c93d2c785114b23c152d0c624edf2ec"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fb36c8ea83c27bd1fd6930d30af9a687c077da6ef4a13cc05a0bad9c6f64b0a2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f38219245c58c4a9af2b861441774b3090b8f62a5a721dddfa359be6f20698ef"
    sha256 cellar: :any_skip_relocation, monterey:       "71faa284707b83456e2318cfcbbc72196efbd2c75eacaa2dbc82a4a7a000461c"
    sha256 cellar: :any_skip_relocation, big_sur:        "7fdd38d77d356264958b2802279dbfc3de1ac2bccabd509cf5fb68ee05e6eb05"
    sha256 cellar: :any_skip_relocation, catalina:       "af6191c0a1eb8b0f7435758dc303030e8eaba288ca12da3090ef8e258ef7e515"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c8916a75da3eb8cd7d53a177f2e82353d94206fdf22c9868a6bb4a29b9e74716"
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
