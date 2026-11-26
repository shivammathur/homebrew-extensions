# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.1.tgz"
  sha256 "a9f092ae84f32f15149a09a9a278bb20d3794cbfb57893eab4933814d7ab2fd5"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "027987d6061e5c7ab2b93067bb0fd1a289877b73eb2cdb43b3176634d6750f66"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5fdabe45dc67326218a6558a832137a1d31baa84910717aa0e3cce5ed72833f1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "69d07295453779a6e0d280a2738ecdd5cfecdc9bfb46f0dacd052d79221a1145"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "480045d42134b95115008d8d70a7064a574115cadc0ea0b7210a25164379ea04"
    sha256 cellar: :any,                 arm64_linux:       "b294aabbce358888df06e7f58ca3cdf661232a0083ee95d0e273d31042d476b3"
    sha256 cellar: :any,                 x86_64_linux:      "1fd7519853efc89b7c03d7b4892398d7c2b9333192664fa0ff322dd0391fd16c"
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
