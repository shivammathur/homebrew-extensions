# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "113b323ffccb2f92b98849bd32f131730e046cf53330f6e776b5a1a68144fc4d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fe82b97f1137d9be664d1c7aaff538839e61171376ebded266d766de838ede21"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e7ea11277c539931500f723760350ebd1ac4297d9befe0c9ad84ecb49fec2c9f"
    sha256 cellar: :any_skip_relocation, sonoma:        "bbbd8e91c774892f642c3d2d059c7296c4cdcb76fb2f88897430e8cfd012ff1a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "022e9ec535f8662c62c038dcd6aa106a108fd0467b543b30ce3b730fdd4cd84d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c002309973b6c70b65969175f114d9e14f7ce42833b865d64ef45de72cbcd249"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
