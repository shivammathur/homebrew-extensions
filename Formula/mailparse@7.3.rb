# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
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
    manifest_sha256 "cc896706e5797ddb50f4f453dd6f4b33be38e96e0deb10a1611c535ea1f0913c"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "3602440a9454ed9ef4497acbb42698d7df5cd37824745aeea11345ec8db83552"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "ef97cd51dcbef39f5192787097a39d5be0906b87721a67ed284f61d9adb80ad6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "b096393fad86cf2947a52fe382355da49c72bf2adb991d202c2a11fc680f6355"
    sha256 cellar: :any,                 arm64_linux:       "b2fb4a34bdc9703ad7299f43e493992a3ba6be3bfc5f03b8fb92dc069b0ed7de"
    sha256 cellar: :any,                 x86_64_linux:      "4ceda43137124b72b1d8c27b03454f09cd3c7a44c79705cb43d3d57ed569c4fc"
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
