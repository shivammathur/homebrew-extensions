# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "68dbebc12ff186d965a51e6ff10c118bdd0b0fa325028e694c5aaff111c44e9a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0fc8c848cae1f422cb725bf98b1bfc42f00acba67849daa967a9ad481dffc0b9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "05ac652a11ae0b4a3364efa45c0d7dcf604320d95fe615a8009ffeca3e04e517"
    sha256 cellar: :any_skip_relocation, ventura:       "a350cf08380c21ace6a031d539131a0f0d8354ed86e043b2a2ca1a325d994a3a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4f46b2b10c272473b788b46e7058315379d27192ebefb350124d451530432fdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "99fcf8320d02b8e07f0554a0f59461c94be16044bd5cd27e958ca512c8bd8e63"
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
