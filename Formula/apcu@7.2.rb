# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "518fcf2eb02f9bd4012624180674acf27bcba2e128687fe0979abc75f3bcbbfb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f77011fe37153d0f212fb222b7fb458c5c49bc35aff8259474d2eb06217dc130"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b9e23480c5e18e6ee66c7d27bd0f14396224fc1c0ba946fa2395c9a2808ec57f"
    sha256 cellar: :any_skip_relocation, ventura:       "9be173843cf0512cce829acecaf149d98c967244472c96a9a1e00414d781085d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "472b0660e8bf43e7a9ffc6252d347dcc4089f94f11ac09eb5b25fb1464544998"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fdb1a99a9d0c71ba5655e69bd3cc1c02a6953caf089725958db53b9b5a19ea82"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
