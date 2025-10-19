# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fe59075da253d5a87f2aa298b92178bdca6ff80ad2a7f92e7b6084ac816fbab1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5bec8b068289b3894af10eed8edea828207dc6ab8c8c5238e0dbf33b0f25e209"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "35cc57cb6d28b33629cb51dcccd79a0ff687a9f281a1112c360dad59dea5d155"
    sha256 cellar: :any_skip_relocation, sonoma:        "b270e0bb1050fc78d8c5c7915c0b17f791ea4dc401749d2b664e425c3dd4f64d"
    sha256 cellar: :any_skip_relocation, ventura:       "c0975423161546c768ac9bb46237bbb04ff4f1cc45434a5a0703d095047a9a3b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "539d09edf464dd1b993ebca30bacae35a843f725bdccb926a03d4faa7138123f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e991fe6d3c87943027230adf715ab901d7e493ae7d188a2ae87c2bc91816a10"
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
