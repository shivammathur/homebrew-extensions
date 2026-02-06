# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0266d5e52039503cf8ac8e5e2cec0678e4eae5a59253ae8057a27c8aa7477e85"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0c436cba1f40a340e4b04da84eba3eadf472af658484c85a22059bbe1ffeaada"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c6761fee6f95a7c328eff509abbf65b1b5cfdef676a49b395f28e5adf9b9f6b6"
    sha256 cellar: :any_skip_relocation, sonoma:        "9e87df468e0b12a71ca44211b25a89799e4d779bb639a7a7f342d216fc97a482"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "350ec9258f1af69f7a99c87d49862a432ba121d4319813a0d73f761411acfc5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60f47ec847a741786992d08aecb43aeb796addfd871b1e0d118dcfa4bc75e09a"
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
