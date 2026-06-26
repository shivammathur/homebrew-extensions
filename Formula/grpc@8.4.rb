# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3d40d9d923f118f683e983011b521eff4bd0543ec1257cce9d4b43e07bd5764f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f3a768ac9e5f18fdedb0f5c8b3a48e9f14435114835b6ca2268c12ef17de17dd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4039478cfa34212705f712ee7d78ef24ecfdbf7a33b3e20356801d56dfdb163d"
    sha256 cellar: :any_skip_relocation, sonoma:        "e5436ed8aee543dbf3b1a59aeac9f6e1e3abe2cadcf3bae27fa4ca8dc5b45be1"
    sha256 cellar: :any,                 arm64_linux:   "297aa2a57ec561d259b302e5a30a20a9455c02bc784bab7aebc98ec0a3ab24b9"
    sha256 cellar: :any,                 x86_64_linux:  "dd8477762e3e473eddd2de9313fd0fba4c02e59d00d91b2ce75dcddcc3c11e86"
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
