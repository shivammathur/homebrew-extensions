# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT83 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "56c8e4d6fc257f9ba507eab471a1b6191b234ca1ce24c7963d2109b7ff95d308"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e48c457b015b672ca5a81839e25aa2a10723440ac50af826c484c0674af57350"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e9d1d8348600c8d687d7318c4774aa54f5a06c18a16c3a488cdbb28fb2e8d50"
    sha256 cellar: :any_skip_relocation, sonoma:        "de38b0242b45813f9430063729ac469e2ead4e51b6f05d517099c21240648b94"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "38bac77bd4b9bc2e38df1de3c07dbc8016a8f4cd5f75bba1db8597cca9e3a8ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e69b780da8275796a92c5f668e5867c7f7ae0d9888677a35541173a3827d8a1c"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
