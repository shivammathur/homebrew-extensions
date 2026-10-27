# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.0.tgz"
  sha256 "adaf30db949767bf0ff5a5308638e4b9bb5f711733204ed5a5e8f3014d80a174"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d2bc335391b388775157e536ee2c892e7aeddcc8a8725105550e7407deaf772f"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "d5040e226dcc0096892065df2e787736cff929d7ed7f780c0524424d09a43dd9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "58cecc73463c237bc102f23a08c245de2c65727f9d2640d78570c1ced6f2f9df"
    sha256 cellar: :any,                 arm64_linux:       "64a4f8e5e1770ab5ec5de877bf63ddd055179eed97877b5ee28458d74fdc5139"
    sha256 cellar: :any,                 x86_64_linux:      "59e8d599c64ad987875c96af6dd4b66c86f2fb0f2c4d4433ba619e810b692ad3"
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
