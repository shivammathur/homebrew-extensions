# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.80.0.tgz"
  sha256 "75e553f2b5c3f7dde99aa984a9601dce6db240bc3c85d7fe09298b5bd8c5d53f"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "72d31c6160e230b8bfedb20a09e66ace2743bc2454b366ad0e672d2e1c63b25b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "50baf2878a03d4819d43a505d20de0e95dde3678d31568c7ba7c82d381174d78"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "340fc88cdb78d2a11ffc6ca918b63d04dc35b7c41a51ba62710398902d72f5a8"
    sha256 cellar: :any_skip_relocation, sonoma:        "0d4198b800bbe41540973f0f3e402953956577abfa02ddd8fea96d044a06ca51"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c534514c85eb23564bf084c0b1a8ff52b61106c31e1ff6c96995fbf82e57eb8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d96c78137ac778c98ec72ae1daa425b71a49a2f1c113bcf8203f603ea42540d9"
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
