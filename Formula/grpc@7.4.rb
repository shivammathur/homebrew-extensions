# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "82b8d6111bed729cff87d185cf904f3635edce00bf44811bfce3ec40f26db8b9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "95e76514ee5b07ca5de1433013b9e4a3028e6b3a3ce28544251758817a4663c9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "157be2b912ba0282855a6f240ba1e746558cb25b99bb47285c6f6bce0d0156cb"
    sha256 cellar: :any_skip_relocation, sonoma:        "0ca553f8433554a955d0a6d210edb9d73346a008efc1718ac020087f24b4d8b1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ea92d11c6e1e7a11659cf86b16a882c153a4013cc7c557108ba3fee79070b91b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "693ab16d4c728cdc732af7edcc8494f0027d6f6313eef60c34b22d1f0135cbee"
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
