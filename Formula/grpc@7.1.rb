# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5f8f5f471a1f65903a16060fc23b81ae60aa3eaa28c6f9a3d99a689ac6fccb62"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "8b2ff483846b39cab61ec697ef57c12ad9b194a2058e94f90799f459acdf8e18"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1e2ac1f5ced25c75942c5fd8850921b2f11548771c440d64a84e887b40d11c93"
    sha256 cellar: :any,                 arm64_linux:       "46aec479941f98e8edf36af6a77e389d131eab68baf61afefca8557696e22678"
    sha256 cellar: :any,                 x86_64_linux:      "7c4b2dde47226a9dfaaa5b0948cc9896dc52d4bbf9562f7aee7251cea69ff6a4"
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
