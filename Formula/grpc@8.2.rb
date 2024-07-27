# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.2.tgz"
  sha256 "5efbfd399f3be464e293bb0ec4a773fae9bb4a43b67362e1fac72bb4cae4bbc3"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "382c81b887b2f632befb385ff3aea1eda035f4a202922e002bb0dac802a6601e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5b8ae8202374c0be2642bf2eb2a37f6c6234eec7e1a258e53532acd70ed42780"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b83939836635f24ae30265eee71356931e1dbc4a4ec5ea5c7dc11d78f5c602e8"
    sha256 cellar: :any_skip_relocation, ventura:        "175d0a454c71054d3d5ede5310cd78595b36e14b87fc99c09859f03212d9f9d8"
    sha256 cellar: :any_skip_relocation, monterey:       "6cb27d0f0be02a3ebc25e7d4ccec00fb3fd5b9735e9373cda3f90f4eb66b0889"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1920717e05f6471d64161dbe89ed56d1f6d87445f770a27054189e01d5caaa36"
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
