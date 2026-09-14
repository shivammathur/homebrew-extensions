# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.84.0.tgz"
  sha256 "555716233a5cc9a6baa605719f87b7688a88fb8bfdd9b4493396276244d56625"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0af535c03e1d198fbb85b0ab25b35bce9a0493aa397c2f9e7566cbf14ee25dfe"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7741f36306d61d18673d09d46a08a2ba8e5972f8e4945b0c46019499700d621e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "8daf21f28d8c3a6d221b8b30e9592cf6db8a362a0fc5f196217b83559d0c136a"
    sha256 cellar: :any,                 arm64_linux:       "90457858a9755534e5d8dfcd9052478be5426712e4fab8bec8f4b0dec79af59d"
    sha256 cellar: :any,                 x86_64_linux:      "77ccb31cabb5323e55a606a329d53416c1d8096ad0548bec5891b0e81d3899f9"
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
