# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "59649bc77c1d9d54b2eabc6fd1ba213c8b180add97f6c58ed2a76b24cfe490fe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dd4e2c9446ab3829296f274b04f22a3f7a6c255b0c8ef8236825252fe6e7e62f"
    sha256 cellar: :any_skip_relocation, sonoma:        "1d1096c663e2a1f90391323e3b025eb718dc8eb9dea9954bab31c486fd54966e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2abc9ff3d72cbea7fccef69e033e470c85ab805fe2bbe75b5e917e1dd4c34318"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0cdd8e059b8e944a2bbecc916668400a28df82854c2456cd2379ab4fef644626"
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
