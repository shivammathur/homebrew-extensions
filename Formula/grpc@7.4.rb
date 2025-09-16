# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0472a96ab2e9611011bb053fc49a467ecd2a61a8a3924b673c0fbed9dbe8f723"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0674fe680be0920cc43effa5565c6bfbc7cb0590c8409f7841c9ee5411b4ce04"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fa9d681ab5a835585040ee5fd3c3227882e7254f9dd7ca6aaff944c624faca00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bf71969b2d4b4baf9eb5afd943726d87fe293579810151bf2a336e3aaa35cfbe"
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
