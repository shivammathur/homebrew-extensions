# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.4.tgz"
  sha256 "eb584cbe54ff361a54a9c0628bb3273b141e7900f5a6d89a43f97137875d7cec"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "12156d0f16785d3eb812326ff1d6dce2970f7f9728e35c0e64835270f98fa1ba"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "da62ae4f9f51fe9a77a20ef8426087c065e7c5be3bb0f3f4ddf49a938dd9a995"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "3255236df4efb15a1f0c7a548ebd7969670e5c481a2de32fcfc7a24a4eb057d8"
    sha256 cellar: :any,                 arm64_linux:       "4f59fc5112897a62a0869c3ef8ee1b14d6a70f45f85e3cdd14244406cb39eed2"
    sha256 cellar: :any,                 x86_64_linux:      "977bc87675b977ebe8b304316eb047b5f5437099efb30c6ea8e3779d9b4d07ba"
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
