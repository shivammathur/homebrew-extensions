# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ed89ffcf50b1513a28c93063bbb982b5848ea039a08298abc7707e935f0f5271"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6cc3cf1b3707b23c2b92f1a2dad75a1dde78e3d3279baa77cf64f5edf1c62ee4"
    sha256 cellar: :any_skip_relocation, sonoma:        "a1470ed96f5c766d4e685565bf39b4c0b1618ba90a427cdc9629cf004138820c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1efc7ffb41853c1b1eb041e47da63c7d686b1b88293cfde98d9276f6a5030be5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a2f8669f69bf3f472a650c4d2f49b0b0a84f540111a802a074da21ceacd52681"
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
