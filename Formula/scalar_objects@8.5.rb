# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT85 < AbstractPhpExtension
  init
  desc "Scalar objects PHP extension"
  homepage "https://github.com/nikic/scalar_objects"
  url "https://github.com/nikic/scalar_objects/archive/86dbcc0c939732faac93e3c5ea233205df142bf0.tar.gz"
  sha256 "a0f621772b37a9d15326f40cc9a28051504d9432ba089a734c1803f8081b0b39"
  version "86dbcc0c939732faac93e3c5ea233205df142bf0"
  head "https://github.com/nikic/scalar_objects.git", branch: "master"
  license "MIT"

  livecheck do
    skip "No tagged releases; using latest commit"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "615936ca179ac4ebf8bdd7f6cd0d6f04560399e313511ab665511ee30ac42185"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "05d9d07101e47a9f6c03fa97b22fe1008032d461c72da5aeab8dff5421f87e03"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1cc3ea2a9205eb9ab85061bbf5607a7096dbc6ea859630e523dd2de2c74c5731"
    sha256 cellar: :any_skip_relocation, sonoma:        "3343742202447058234f8029cc7113e17663ca08458017e42456975eda875507"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5f3501ab895a61de16284bb87a7d4354f6632a24a021333a172a254f3a8a73a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aade96749107a1bebbba7bf886cc8ac73bead3c9c46503451cd6210af81c52bd"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
