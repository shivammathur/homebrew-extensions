# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1e4ffbb1fc25bfe420319f8f3479969d60a2650793ba13b9843f4dbc43ddfb19"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "eda9bb579d07cd73d83a2f3af42f3c5ca571341fbd7dcb60a2499f4de3e02778"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6bf6eb8825482c8015bd69919c1fe3c752c0e9a98b0a530faa33658b7805af76"
    sha256 cellar: :any_skip_relocation, sonoma:        "75d06998389b001195bad7e1a8ddce519cffd9d9ed27dc98e913c34a82d0a84b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9ec99c327d52d9936765922f3d6a23142ab16fe6787fd538864d197827242d8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de842e5161e815ea78aaad6fcff60bb8b5510308b562bdad0cf2231e145b985e"
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
