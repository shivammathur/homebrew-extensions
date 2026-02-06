# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT72 < AbstractPhpExtension
  init
  desc "Seaslog PHP extension"
  homepage "https://github.com/SeasX/SeasLog"
  url "https://pecl.php.net/get/SeasLog-2.2.0.tgz"
  sha256 "e40a1067075b1e0bcdfd5ff98647b9f83f502eb6b2a3d89e67b067704ea127da"
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9b55ecb04893a2b2920dc73b1ac86ac5795dd2566376b7fbe9ba45db19ccf696"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "96ab98670b6e62c2f847f2ebdd9c51fe3248dcf8979c47b5168dcde15601f9a8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "714dd958a32b50ab60c78cf289b0ad471920a708927142309c8c4748a289665c"
    sha256 cellar: :any_skip_relocation, sonoma:        "177dac8f7647dc44f0800c4801359a35dc8030e33bd383bf2d7af724bcedd6c8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ebff1e848e640d90f3de86731a2f1bec7f6d8a07e9cb49d55d00c876b06e60ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b945866ed927b5d3bd31b1a9e657386fd009eeb5495477ac50729c9d3e76d551"
  end

  def install
    Dir.chdir "SeasLog-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-seaslog"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
