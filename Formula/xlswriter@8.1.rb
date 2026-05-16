# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.0.tgz"
  sha256 "0562a41c958a20780b492f91c3815744d976e42e4adac09edb4d2c5add7b0cc7"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1738f74e767d330bb8d3aba191c297d9b27c53ccb1fb5f06e00ed89d37969ff7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3fd85093875afd46301ba777d38dfafaeaca4cc50c6e99eb58f5234ae9daaf95"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "82ebb69976be9fa0f23d18ae0d89fa9262f5cc468c73b918520e79e6d8fb12e3"
    sha256 cellar: :any_skip_relocation, sonoma:        "6f47058fbce509cec5157a9262501621f5bd2577eb6c4f99f6a5d73f2c5ab71c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "85f19bc701541919e9c463fa5cd2c4ae05d2490f39c7323fd9294f0c88856bcc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b041779f336f3709965ca4c275f1a58eceb069a7d1d8071a2306a395a0c64634"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
