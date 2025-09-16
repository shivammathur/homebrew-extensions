# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "984b8a45823c97daf404707fff01d28b1c746517e025960b86877f0ff9927053"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f98f840dba5ff953e5db170a5a66926cf7e875d0017a7933a9e214e0dbfc36c8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fff35f8929fe4293474da48a7521c4529dae6c944b9586a8c5ac29828eeed84f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "12a7a9316eb1deefafda1587031534e6650612c7d393477338eba508840ad75c"
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
